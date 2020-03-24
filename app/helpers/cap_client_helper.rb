module CapClientHelper

  def applications_url(path)
    URI.join(cap_host, path).to_s
  end

  def cap_url(path)
    URI.join(cap_host, path).to_s
  end

  def cap_host
    ENV['APPL_URL'].presence || "#{Settings.cap.protocol}://#{Settings.cap.host}"
  end

end
