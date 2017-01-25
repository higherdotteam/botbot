class SlackController < ApplicationController

  def slack
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
end
