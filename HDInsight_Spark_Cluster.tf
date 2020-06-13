provider "azurerm" {
    subscription_id               = "87e0d99a-1770-4c66-8951-000000000000"
    client_id                     = "25fd9d4b-ca4b-4c80-8ce2-000000000000"
    client_secret                 = "85180c8b-e84a-4740-9904-000000000000"
    tenant_id                     = "307321ff-a34b-4201-9d21-000000000000"
    environment                   = "china"
    version                       = "=2.13"
    features {}
}

resource "azurerm_resource_group"          "demohdi" {
    name                          = "demohdi_rg"
    location                      = "chinanorth2"
}

resource "azurerm_storage_account"         "demohdi" {
    name                          = "demohdistorage"
    resource_group_name           = azurerm_resource_group.demohdi.name
    location                      = azurerm_resource_group.demohdi.location
    account_tier                  = "Standard"
    account_replication_type      = "LRS"
}

resource "azurerm_storage_container"       "demohdi" {
    name                          = "demohdicontainer"
    storage_account_name          = azurerm_storage_account.demohdi.name
    container_access_type         = "private"
}

resource "azurerm_hdinsight_spark_cluster" "demohdi" {
    name                          = "demohdi"
    resource_group_name           = azurerm_resource_group.demohdi.name
    location                      = azurerm_resource_group.demohdi.location
    cluster_version               = "3.6"
    tier                          = "Standard"

    component_version {
        spark                     = "2.3"
    }

    storage_account {
        storage_container_id      = azurerm_storage_container.demohdi.id
        storage_account_key       = azurerm_storage_account.demohdi.primary_access_key
        is_default                = true
    }

    gateway {
        enabled                   = true
        username                  = "gwuser"
        password                  = "QAZwsx!123"
    }

    roles {
        zookeeper_node {
            vm_size               = "Medium"
            username              = "vmuser"
            password              = "EDCrfv!123"
        }

        head_node {
            vm_size               = "STANDARD_D1_V2"
            username              = "vmuser"
            password              = "EDCrfv!123"
        }

        worker_node {
            vm_size               = "STANDARD_D1_V2"
            username              = "vmuser"
            password              = "EDCrfv!123"
            target_instance_count = 3
        }
    }
}