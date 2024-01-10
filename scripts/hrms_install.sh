# Set container name
CONTAINER_NAME="c1"

# Set frappe user password
FRAPPE_PASSWORD="frappe"

# Set old and new server names
OLD_SERVER_NAME="127.0.0.1"
NEW_SERVER_NAME=$1  # Change this to your desired new server name

# Pull Docker image
sudo docker pull indictrans/erpnext_setups:erpv15

# Create and run container
sudo docker run -d -it --name $CONTAINER_NAME -p 80:80 indictrans/erpnext_setups:erpv15

# Check if the nginx.conf file exists
if sudo docker exec $CONTAINER_NAME bash -c '[ -f /home/frappe/webapp/frappe-bench/config/nginx.conf ]'; then
    # Update Nginx configuration with new server name
    sudo docker exec $CONTAINER_NAME bash -c "\
      sed -i 's/server_name $OLD_SERVER_NAME;/server_name $NEW_SERVER_NAME;/' /home/frappe/webapp/frappe-bench/config/nginx.conf && \
      echo \"$FRAPPE_PASSWORD\" | sudo -S service nginx restart && \
      cd /home/frappe/webapp/frappe-bench && \
      source ../bin/activate && \
      echo \"$FRAPPE_PASSWORD\" | sudo -S service mariadb start && \
      echo \"$FRAPPE_PASSWORD\" | sudo -S service supervisor start && \
      echo \"$FRAPPE_PASSWORD\" | sudo -S supervisorctl restart all"
else
    echo "Error: nginx.conf file not found in the specified path."
fi