class EventsController < ApplicationController

  def index
    @event  = Event.new
    @events = Event.all

    @meetups = meetups

  end

  def show
    begin
      @event = Event.find( params[ :id ] )
    rescue
      head :not_found
    end
  end

  def meetup_api
    @meetups = meetups
    render :json => meetups
  end

  def nomz
    meetup_id = params[:id]
    meetup_name = params[:name]
    meetup_venue = params[:venue]
    meetup_group = params[:group]
    meetup_link = params[:link]
    meetup_time = params[:time]

    unless Event.where(meetup_id: meetup_id).exists?
      newevent = Event.new({meetup_id: meetup_id,
                                 name: meetup_name,
                                 venue: meetup_venue,
                                 link: meetup_link,
                                 group: meetup_group,
                                 happens_at: meetup_time
                                })
      newevent.save
    end

    current_user.events << Event.where(meetup_id: meetup_id)

    render '/events/index'
  end


  protected

    def meetups( page = 10 )
      # RMeetup::Client.api_key = "145368d59141781a514078586d19"
      # return RMeetup::Client.fetch(:events,{:zip => "EC1R 5DF"})
      response = RestClient.get 'https://api.meetup.com/2/open_events?', {
        :params => {
          'sign' => 'true',
          'city' => 'London',
          'category' => 34,
          'zip' => 'EC1R 5DF',
          'page' => page,
          'key' => '4a10285e45445e77313a62f737c275d',
          'text_format' => 'plain'
        }, :content_type => "application/json; charset=utf-8", :accept => :json
      }

      response = response.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
      response = JSON.parse(response)['results']
      response = response.to_json
      response
    end

end
