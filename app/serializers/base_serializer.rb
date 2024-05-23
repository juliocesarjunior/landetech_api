class BaseSerializer < ActiveModel::Serializer
    
    include ActionView::Helpers::TranslationHelper
    include Rails.application.routes.url_helpers


    def created_at
        l object.created_at
    end

    def updated_at
        l object.updated_at
    end
end
