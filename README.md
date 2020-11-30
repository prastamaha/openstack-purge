# Purge All Openstack Resource

### resources to be deleted

- Stack
- Instance
- Volume
- Floating IP
- Router Interface
- Router
- Port
- Subnet
- Network
- Image
- Keypair
- Security Group (except default)
- Flavor

### How to Use?

1.  Clone Repository

    ```
    git clone https://github.com/prastamaha/openstack-purge.git
    cd openstack-purge
    ```

2. Run Script

    ```
    ./openstack-purge.sh /path/to/admin-rc /path/to/venv
    ```

    > You can exclue `/path/to/venv` if you are not using virtual environment