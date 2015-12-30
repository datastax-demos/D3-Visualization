VAGRANTFILE_API_VERSION = '2'

DEMO_NAME = 'd3.js-demos-1-eric.coopey'

# Ubuntu 14.04 LTS
# http://cloud-images.ubuntu.com/locator/ec2/
# "14.04 amd64 hvm:ebs-ssd"
# Could also use "hvm:ebs-io1"
AMI_LIST = {
    'ap-northeast-1' => 'ami-40e1e641',
    'ap-southeast-1' => 'ami-07597455',
    'ap-southeast-2' => 'ami-39086103',
    'eu-west-1' => 'ami-5a4bfb2d',
    'eu-central-1' => 'ami-d21223cf',
    'sa-east-1' => 'ami-798f3e64',
    'us-east-1' => 'ami-92f569fa',
    'us-west-1' => 'ami-71150534',
    'us-west-2' => 'ami-8b84d0bb'
}

vb_setup = Proc.new do |vb, override|
    override.vm.network :private_network, type: 'dhcp'
    override.vm.box = 'ubuntu/trusty64'

    vb.memory = 512
    vb.cpus = 1
end

aws_setup = Proc.new do |aws, override|
    override.vm.box = 'aws-dummy'
    override.ssh.username = 'ubuntu'

    aws.access_key_id = ENV['DEMO_AWS_ACCESS_KEY']
    aws.secret_access_key = ENV['DEMO_AWS_SECRET_KEY']
    aws.region = ENV['DEMO_AWS_REGION']
    aws.availability_zone = ENV['DEMO_AWS_AZ']
    aws.ami = AMI_LIST[aws.region]
    aws.instance_type = 'm1.small'

    aws.keypair_name = ENV['DEMO_AWS_KEYPAIR_NAME']
    override.ssh.private_key_path = ENV['DEMO_AWS_KEYPAIR_LOCATION']

    aws.security_groups = [ENV['DEMO_AWS_SECURITY_GROUP']]

    aws.tags = {
        'Name' => "#{DEMO_NAME}-vagrant",
        'Owner' => ENV['DEMO_USER'],
        'Email' => ENV['DEMO_EMAIL']
    }
end

bootstrap = Proc.new do |config|
    config.vm.provision :shell, path: 'vagrant/software-bootstrap.sh',
                                privileged: false
    config.vm.provision :shell, inline: 'hostname -i'

    config.vm.post_up_message = 'Run /vagrant/vagrant/web-server.sh on the machine.'
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.define 'demo', autostart: true do |demo|

        demo.vm.provider :virtualbox do |vb, override|
            vb_setup.call vb, override
        end

        demo.vm.provider :aws do |aws, override|
            aws_setup.call aws, override
        end

        bootstrap.call demo

    end

end
