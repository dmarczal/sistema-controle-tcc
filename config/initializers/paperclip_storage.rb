module PaperclipStorage
  module ClassMethods
    def options
      #production_options
      #Rails.env.production? ? production_options : default_options
      default_options
    end

    private
    def production_options
      {
        storage: :dropbox,
        dropbox_credentials: Rails.root.join("config/dropbox.yml")
      }
    end

    def default_options
      {
        :url  => "/attachments/:class/:id/:basename.:extension",
        :path => ":rails_root/public/attachments/:class/:id/:basename.:extension",
      }
    end
  end

  extend ClassMethods
end
