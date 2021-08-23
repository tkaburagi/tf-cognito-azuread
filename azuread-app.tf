resource "azuread_application" "ad-app" {
  display_name = "ad-app"
}

resource "azuread_service_principal" "ad-app-principal" {
  application_id = azuread_application.ad-app.application_id
  tags = [
    "WindowsAzureActiveDirectoryIntegratedApp",
    "WindowsAzureActiveDirectoryCustomSingleSignOnApplication",
    "WindowsAzureActiveDirectoryGalleryApplicationNonPrimaryV1"
  ]

//  provisioner "local-exec" {
//    command = "sleep 120"
//  }

  provisioner "local-exec" {
    command = "az ad sp update --id ${azuread_application.ad-app.application_id} --set preferredSingleSignOnMode='saml'"
  }

//  provisioner "local-exec" {
//    command = "sleep 120"
//  }


  provisioner "local-exec" {
    command = "az rest --method PATCH --uri 'https://graph.microsoft.com/v1.0/applications/${azuread_application.ad-app.object_id}' --body '${data.template_file.body.rendered}'"
  }

  depends_on = [
    azuread_application.ad-app
  ]
}

data "template_file" "body" {
  template = file("patch-ad.json.tpl")
  vars = {
    replyurl = "https://${aws_cognito_user_pool_domain.kabuctl.domain}.auth.${var.region}.amazoncognito.com/saml2/idpresponse",
    identifier = "urn:amazon:cognito:sp:${aws_cognito_user_pool.pool.id}"  }
}