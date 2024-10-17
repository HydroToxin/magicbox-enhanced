# App.dashboards = App.cable.subscriptions.create "DashboardsChannel",
#   connected: ->
#     console.log("Connected to Dashboard Channel")
#     console.log(moment().format('dddd, D. MMMM, HH:mm [Uhr]'));
#     # Called when the subscription is ready for use on the server

#   disconnected: ->
#     console.log("Disconnected to Dashboard Channel")
#     # Called when the subscription has been terminated by the server

#   received: (data) ->
#     # Called when there's incoming data on the websocket for this channel
#     $('h5.font-weight-light.text-info.cpu-temp').text(data.cpu_temp);
#     $('h5.font-weight-light.text-info.cpu-usage').text(data.cpu_usage);
#     $('h5.font-weight-light.text-info.voltage').text(data.cpu_voltage);
#     $('h5.font-weight-light.text-info.used-memory').text(data.used_memory);
#     $('h5.font-weight-light.text-info.free-memory').text(data.free_memory);

#     $('.text-info.temperature').text(data.temperature);
#     $('.text-info.humidity').text(data.humidity);
