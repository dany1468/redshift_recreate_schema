require 'yaml'
require 'redshift_recreate_schema/version'

module RedshiftRecreateSchema
  class << self
    def configuration
      @configuration ||= Configuration.new
    end
  end

  def self.configure
    yield(configuration)
  end

  def self.load(config_file, environment = 'development')
    env = environment || ENV['RAILS_ENV']
    config = YAML.load_file(config_file)[env]

    config.each do |k, v|
      configuration.__send__("#{k}=", v)
    end
  end

  class Configuration
    attr_accessor :host, :port, :dbname, :user, :password, :connect_timeout
  end
end
