module TokenAuthentication
  def login_with_token(user)
    auth_headers = user.create_new_auth_token
    request.headers.merge!(auth_headers)
  end
end
