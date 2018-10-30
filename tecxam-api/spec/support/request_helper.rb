module RequestHelpers
  def json
    JSON.parse(response.body)
  end

  def json_headers
    {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json',
    }
  end

  def auth_headers(user)
    Devise::JWT::TestHelpers.auth_headers(json_headers, user)
  end
end
