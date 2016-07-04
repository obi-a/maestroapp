class PagesController < ApplicationController
  def home
    @guest_monitor = guest_user.ragios_monitors.first || RagiosMonitor.new
  end

  def about
  end

  def doc
  end

  def contact_us
  end

  def how_it_works
  end
end
