resource "azurerm_resource_group" "VM" {
  name     = "virtualmachine"
  location = "West Europe"
}

resource "azurerm_virtual_network" "VMnetwork" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.VM.location
  resource_group_name = azurerm_resource_group.VM.name
}

resource "azurerm_subnet" "VMsubnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.VM.name
  virtual_network_name = azurerm_virtual_network.VMnetwork.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "VMinterface" {
  name                = "example-nic"
  location            = azurerm_resource_group.VM.location
  resource_group_name = azurerm_resource_group.VM.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.VMsubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "VM" {
  name                = "example-machine"
  resource_group_name = azurerm_resource_group.VM.name
  location            = azurerm_resource_group.VM.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.VM.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
