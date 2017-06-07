module MainConfig

  def MainConfig.config
    config  = {
        :db_params => {
            :host => "localhost",
            :username => "root",
            :password => "root",
            :database => "test"}
    }
  end
end

config  = {
    :db_params => {
        :host => "localhost",
        :username => "root",
        :password => "root",
        :database => "test"}
}
p config