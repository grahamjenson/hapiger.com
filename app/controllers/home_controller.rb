class HomeController < ApplicationController
  def home
    if Rails.env.development?
      require 'github/markdown'
      file = 'README.md'
      $README = GitHub::Markdown.render_gfm(File.read(file)).gsub(/\n/, "&#x000A;")
    end
  end

  def support
  end

  def subscribe
    if params[:EMAIL].present?
      mailchimp = Mailchimp::API.new(ENV['MAILCHIMP_API_KEY'])
      mailchimp.lists.subscribe(ENV['MAILCHIMP_LIST_ID'], { "email" => params[:EMAIL]})
      flash[:notice] = "Thank you for subscribing"
      flash[:error] = ""
    else
      flash[:error] = "Please put a valid email address"
      flash[:notice] = ""
    end
    render :home
  end

end
