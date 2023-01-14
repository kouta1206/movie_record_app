class ApplicationController < ActionController::API
    # Cookeiを扱うモジュール
    include ActionController::Cookies
    # 認可を行う
    include UserAuthenticateService
end
