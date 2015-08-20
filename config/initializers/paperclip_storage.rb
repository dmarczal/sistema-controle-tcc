module PaperclipStorage
  module ClassMethods
    def options
      production_options
      #Rails.env.production? ? production_options : default_options
    end

    private
    def production_options
      {
        storage: :dropbox,
        dropbox_credentials: Rails.root.join("config/dropbox.yml")
      }
    end

    def default_options
      {}
    end
  end

  extend ClassMethods
end
