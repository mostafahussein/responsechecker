require 'cookiejar'

module ResponseChecker
  class SecureCookieCheck
    def name
      'Secure cookie'
    end

    def description
    end

    def perform(request, response)
      return true if response['set-cookie'].nil?

      cookies = Array(response.to_hash['set-cookie']).map do |cookie_string|
        CookieJar::Cookie.from_set_cookie(
          request.uri.to_s,
          cookie_string
        )
      end

      cookies.all?(&:secure)
    end
  end
end
