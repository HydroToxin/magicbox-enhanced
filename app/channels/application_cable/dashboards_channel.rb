class DashboardsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "dashboards_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
