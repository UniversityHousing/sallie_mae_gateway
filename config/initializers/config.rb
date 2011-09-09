user_config = File.join(Rails.root,"config","salliemae.yml")
if File.exists?(user_config)
  config_path = user_config
else
  config_path = File.dirname(__FILE__) + "/../salliemae.yml"
end
SALLIE_MAE_CONFIG = YAML.load_file(config_path)[Rails.env]