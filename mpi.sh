#!/bin/sh

ssh-keygen -t rsa -b 4096  -f "id_rsa" -q -P ""

echo "
#!/bin/sh

echo \"apt-get update\"
sudo apt-get update

echo \"install vim\"
sudo apt-get -y install vim

echo \"install htop\"
sudo apt-get -y install htop

echo \"install build-essential\"
sudo apt-get -y install build-essential

echo \"install ssh\"
sudo apt-get -y install openssh-client openssh-server

echo \"install OpenMPI\"
wget https://download.open-mpi.org/release/open-mpi/v4.0/openmpi-4.0.0.tar.gz
gunzip -c openmpi-4.0.0.tar.gz | tar xf -
cd openmpi-4.0.0
./configure --prefix=/usr/local
sudo make all install

echo \"export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH\" >> /home/cpd1/.bashrc

echo \"clear\"
cd ..
sudo rm -rf openmpi-4.0.0
rm openmpi-4.0.0.tar.gz

echo \"Installation completed\"

echo \"create user cpd1\"
sudo useradd -s /bin/bash -d /home/cpd1/ -m -G sudo cpd1
echo -e \"root\nroot\" | sudo passwd cpd1
echo \"user cpd1 created\"


echo \"configure ssh...\"

#Change here using your private key
echo \"`cat id_rsa`\"  > id_rsa

#Change here using you public key
echo \"`cat id_rsa.pub`\"  > id_rsa.pub

#Change here using you public key
echo \"`cat id_rsa.pub`\"  >> authorized_keys

echo \"Host *
   StrictHostKeyChecking no
   UserKnownHostsFile=/dev/null\" >> config

chmod 600 id_rsa
chmod 640 id_rsa.pub

sudo mkdir  -p /home/cpd1/.ssh

sudo mv id_rsa /home/cpd1/.ssh
sudo mv id_rsa.pub /home/cpd1/.ssh
sudo mv config /home/cpd1/.ssh
sudo mv authorized_keys /home/cpd1/.ssh

sudo chown cpd1:cpd1 /home/cpd1/.ssh
sudo chown cpd1:cpd1 /home/cpd1/.ssh/config
sudo chown cpd1:cpd1 /home/cpd1/.ssh/id_rsa
sudo chown cpd1:cpd1 /home/cpd1/.ssh/id_rsa.pub
sudo chown cpd1:cpd1 /home/cpd1/.ssh/authorized_keys
echo \"ssh configurated\"

echo \"ldconfig on user cpd1\"
echo -e \"root\n\" | sudo -u cpd1 sudo -S ldconfig

" > install.sh
