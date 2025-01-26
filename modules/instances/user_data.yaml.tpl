#cloud-config
package_update: true
package_upgrade: true
packages:
  - apache2
  - python3-pip

write_files:
  - path: /var/www/html/index.html
    content: |
      <html><body><h1>Welcome to SMM home work cool web-server</h1>
      <p>Here is my image:</p>
      <img src='${s3_image_url}' alt='S3 Image'/>
      </body></html>
  - path: /var/www/html/debug.txt
    content: |
      S3 Image URL: ${s3_image_url}

runcmd:
  - sudo apt install python3-pip
  - pip3 --version
  - pip3 install awscli --force-reinstall --upgrade
  - systemctl start apache2
  - systemctl enable apache2
  - echo "Checking AWS CLI version..." >> /var/www/html/index.html
  - aws --version >> /var/www/html/index.html 2>&1
  - echo "Starting Apache service..." >> /var/www/html/index.html
  - aws s3 cp /var/www/html/index.html s3://hw-smmikh-january-2025-store-bucket/index.html >> /var/www/html/index.html 2>&1
  - systemctl restart apache2
