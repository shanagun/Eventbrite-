class EventsController < ApplicationController
  #permet de savoir si l'utilisateur est connecté et lui laisser l'accès si c'est le cas 
  before_action :authenticate_user, only: [:new, :create, :destroy]
  before_action :is_owner, only: [:edit, :update, :destroy]
  
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @attendees = Attendance.users(@event)
  end
  

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(title: params[:title], description: params[:description], price: params[:price], duration: params[:duration], start_date: params[:start_date], location: params[:location], admin_id: current_user.id)
    if @event.save # essaie de sauvegarder en base @gossip
        flash[:success] = "Votre évènement a été crée correctement"
        redirect_to :controller => 'events', :action => 'show', id: @event.id
    else
      # This line overrides the default rendering behavior, which
      # would have been to render the "create" view.
      flash.now[:danger] = "Votre évènement n'a pas pu être créé"
      render :action => 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to :action => "index"
  end

  def authenticate_user
    unless current_user 
      flash[:danger] = "Vous devez être connectés pour avoir accès à cette page."
      redirect_to new_user_session_url
    end
  end

  def is_owner
    if current_user.id.to_i != Event.find(params[:id]).admin_id
      flash[:danger] = "Vous n'avez pas pas l'autorisation pour cette action"
      redirect_to "/"
    end
  end

end
