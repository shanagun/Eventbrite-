class AttendancesController < ApplicationController
  before_action :authenticate_user
  before_action :find_event, only: [:create]


  def index
    @attendances = Attendance.all
  end

  def show

  end

  def new
    @attendance = Attendance.new
  end


  def create
    if already_participate?
      flash[:danger] = "Il n'est pas possible de s'inscrire plusieurs fois a un evenement"
      redirect_to event_path(@event)
    end

    # Amount in cents
    @amount = @event.price

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })

    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'eur',
    })

    @event.attendances.create(user_id: current_user.id)
    redirect_to event_path(@event), flash: {success: 'Super, vous etes insrit a un nouvel evenement !'}

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to event_path(@event)
  end

  def destroy
    find_attendance
    if @attendance.destroy
    end
      redirect_to events_path, flash: {danger: 'Vous etes desinscrit de cet evenement !'}
    
  end

  private
  def find_attendance
    @attendance = Attendance.where(user_id: current_user.id, event_id: params[:event_id]).first
  end
   
    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      params.fetch(:attendance, {})
    end

    def find_event
      @event = Event.find(params[:event_id])
    end

    def already_participate?
      Attendance.where(user_id: current_user.id, event_id: params[:event_id]).exists?
    end

    def authenticate_user
      unless current_user 
        flash[:danger] = "Vous devez être connectés pour avoir accès à cette page."
        redirect_to new_user_session_url
      end
    end
    
end