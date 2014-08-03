class HelpController < ApplicationController
  before_filter :authenticate_user!, :except => [:about, :cookies, :index, :terms]
  def about
  end

  def cookies
  end

  def index
  end

  def terms
  end
end
