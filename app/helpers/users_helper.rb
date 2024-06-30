module UsersHelper
    def gravatar_for(user, size: 80)
        gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.name, class: "gravatar")
    end

    def avatar_for(user, size: 150)
        if user.avatar.attached?
            image_tag Rails.application.routes.url_helpers.rails_blob_path(user.avatar, only_path: true), class: "avatar", style: "width: #{size}px; height: #{size}px;"
        else
            image_tag default_avatar_url, alt: user.name, class: "avatar", style: "width: #{size}px; height: #{size}px;"
        end
    end

    def default_avatar_url
        ActionController::Base.helpers.asset_path("images.jpg")
    end
end
