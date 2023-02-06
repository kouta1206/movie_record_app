class AccessTmdb
    include ActiveModel::Model

    class << self
        def all(params)
            AccessApi.search(params)
        end
    end
end
