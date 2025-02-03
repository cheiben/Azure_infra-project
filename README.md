## AzureMultiTierSecure

### Project Directory Structure:

```bash
├── backend.tf        # Remote backend configuration
├── main.tf           # Root module calls
├── variables.tf      # Global variables
├── outputs.tf        # Global outputs
└── modules/
    ├── resource_group/
    ├── network/
    ├── compute/
    └── security_center/ 
```

**AzureMultiTierSecure is a Terraform-based project that deploys a secure, multi-tier infrastructure on Microsoft Azure. It demonstrates best practices for modular Infrastructure as Code (IaC), including remote state management with Azure Blob Storage and conditional resource creation. This project is ideal for hosting web applications with separate public and private subnets, multi-tier enterprise applications, or secure development/testing environments.**

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Directory Structure](#directory-structure)
- [Prerequisites](#prerequisites)
- [Setup and Usage](#setup-and-usage)
  - [1. Configure the Remote Backend](#1-configure-the-remote-backend)
  - [2. Initialize and Deploy](#2-initialize-and-deploy)
  - [3. Deploying Public vs. Private VMs](#3-deploying-public-vs-private-vms)

## Overview

This project uses Terraform to provision a full set of Azure resources including:

- A **Resource Group**
- A **Virtual Network** with two subnets:
  - A **public subnet** for Internet-accessible resources.
  - A **private subnet** for internal resources.
- A **Network Security Group (NSG)** with an SSH rule.
- A **Compute Module** that deploys a Linux Virtual Machine (VM) either in the public subnet (with a public IP) or in the private subnet.
- A **Security Center** configuration.
- **Remote State Management** using Azure Blob Storage for secure state locking and collaboration.

## Features

- **Modular Design:**  
  The code is organized into modules (resource group, network, compute, and security center) for improved reusability and maintainability.

- **Remote State with Locking:**  
  Uses Azure Blob Storage as a remote backend for Terraform state, enabling state locking and centralized state management.

- **Conditional Resource Creation:**  
  Deploys a public IP only if the VM is meant to be publicly accessible, using a `public_vm` variable.

- **Multi-Tier Infrastructure:**  
  Provides a basic architecture suitable for web applications, enterprise solutions, and secure development environments.

## Architecture

The architecture consists of:
- A single **Resource Group** that holds all resources.
- A **Virtual Network** with two subnets:
  - **Public Subnet:** For resources that require Internet access (e.g., public VM, load balancers).
  - **Private Subnet:** For resources that should remain internal.
- An **NSG** that controls inbound and outbound traffic.
- A **Compute Module** that creates a Linux VM attached to a network interface in the chosen subnet.
- A **Remote Backend** configured with Azure Blob Storage to store the Terraform state file securely.

## Prerequisites

- **Terraform** (version >= 1.0)
- **Azure CLI** (for resource creation and authentication)
- An active **Azure Subscription**
- A text editor (e.g., VS Code) for editing Terraform files

## Setup and Usage

### 1. Configure the Remote Backend

Before deploying your infrastructure, you must set up the backend storage for your Terraform state. You can do this manually with the Azure CLI or by using bash script .

```bash
chmod +x setup_backend.sh
./setup_backend.sh
```

## 2. Deploying Public vs Private VMs
- The compute module uses a boolean variable public_vm to determine if a VM should have a public IP:
 - public VM

  **terraform apply -var="public_vm=true"**
 
## Modules Breakdown
- Resource Group Module:
Creates the resource group that holds all resources.

- Network Module:
Creates the Virtual Network, public and private subnets, and associates an NSG with both subnets.

- Compute Module:
Deploys a Linux VM with a network interface. Optionally creates and attaches a public IP if public_vm is true.

- Security Center Module:
Configures the Azure Security Center subscription pricing.

by#CheikhB
