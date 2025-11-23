data "azurerm_image" "app-image" {
  name_regex          = "${var.image}_${var.location}_*"
  resource_group_name = var.image_resource_group
  sort_descending     = true
}