module OmniAuthTestHelper
    def valid_google_login
        OmniAuth.configure do |c|
            c.test_mode = true
            c.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
            provider: "google_oauth2",
            uid: "12341234",
            info: {
                full_name: "test account",
                email: "test@account.com"
            },
            credentials: {
                token: "token",
                refresh_token: "refresh token"
            }
            })
        end
    end
    def invalid_google_login
        OmniAuth.configure do |c|
            c.test_mode = true
            c.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
            provider: "google_oauth2",
            uid: "12341234",
            info: {
            },
            credentials: {
                token: "token",
                refresh_token: "refresh token"
            }
            })
        end
    end
end