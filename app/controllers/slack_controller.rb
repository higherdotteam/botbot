class SlackController < ApplicationController

  def auth
       #{"ok":true,"access_token":"6f","scope":"identify,bot","user_id":"U1","team_name":"higher.team","team_id":"TL","bot":{"bot_user_id":"UP","bot_access_token":"zg"}} 

    code = params[:code]

    url = "https://slack.com/api/oauth.access?client_id=" + 
          ENV['BOTBOT1'] + "&client_secret=" + ENV['BOTBOT2'] + "&code=" + code
    response = Net::HTTP.get_response(URI.parse(url))
    begin
      data = JSON.parse(response.body)
      b = Bot.new
      b.user_token = data["access_token"]
      b.user_id = data["user_id"]
      b.team = data["team_name"]
      b.team_id = data["team_id"]
      b.bot_id = data["bot"]["bot_user_id"]
      b.bot_token = data["bot"]["bot_access_token"]
      b.save
    rescue Object => o
      puts o.inspect
      puts "ERROR: could not parse response"
    end
    redirect_to '/'
  end

  def event
    data = JSON.parse(request.raw_post)
    #puts data.inspect
    team_id = data["team_id"]

    b=Bot.where(team_id: team_id).order(:id).last

    return unless b

    et = data["event"]["type"]
    from = data["event"]["user"]
    bot_id = data["event"]["bot_id"]
    subtype = data["event"]["subtype"]
    text = data["event"]["text"]
    chan = data["event"]["channel"]
    ts = data["event"]["ts"].to_f

    return if bot_id == b.bot_id
    return if subtype == "bot_message"

    client = Slack::Client.new(token: b.bot_token)
  end
end
