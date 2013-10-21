class TutorsController < ApplicationController
  # GET /tutors
  # GET /tutors.json
  def index
    @tutors = Tutor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tutors }
    end
  end

  # GET /tutors/1
  # GET /tutors/1.json
  def show
    @tutor = Tutor.find(params[:id])
    @is_admin = current_user && current_user.id == @tutor.id

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tutor }
    end
  end

  # GET /tutors/new
  # GET /tutors/new.json
  def new
    if current_user
      redirect_to root_path, :notice => "You are already registered" 
    end
    @tutor = Tutor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tutor }
    end
  end

  # GET /tutors/1/edit
  def edit
    @tutor = Tutor.find(params[:id])
    if current_user.id != @tutor.id
      redirect_to @tutor
    end
  end

  # POST /tutors
  # POST /tutors.json
  def create
    @tutor = Tutor.new(params[:tutor])

    respond_to do |format|
      if @tutor.save
        format.html { redirect_to @tutor, notice: 'Tutor was successfully created.' }
        format.json { render json: @tutor, status: :created, location: @tutor }
      else
        format.html { render action: "new" }
        format.json { render json: @tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tutors/1
  # PUT /tutors/1.json
  def update
    @tutor = Tutor.find(params[:id])

    respond_to do |format|
      if @tutor.update_attributes(params[:tutor])
        format.html { redirect_to @tutor, notice: 'Tutor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutors/1
  # DELETE /tutors/1.json
  def destroy
    @tutor = Tutor.find(params[:id])
    @tutor.destroy

    respond_to do |format|
      format.html { redirect_to tutors_url }
      format.json { head :no_content }
    end
  end

  def oauth
    if !params[:code]
      return redirect_to('/')
    end

    redirect_uri = url_for(:controller => 'tutors', :action => 'oauth', :tutor_id => params[:tutor_id], :host => request.host_with_port)
    @tutor = Tutor.find(params[:tutor_id])
    begin
      @tutor.request_wepay_access_token(params[:code], redirect_uri)
    rescue Exception => e
      error = e.message
    end

    if error
      redirect_to @tutor, alert: error
    else
      redirect_to @tutor, notice: 'We successfully connected you to WePay!'
    end
  end
  # GET /tutors/buy/1
  def buy
    redirect_uri = url_for(:controller => 'tutors', :action => 'payment_success', :tutor_id => params[:tutor_id], :host => request.host_with_port)
    @tutor = Tutor.find(params[:tutor_id])
    begin
      @checkout = @tutor.create_checkout(redirect_uri)
    rescue Exception => e
      redirect_to @tutor, alert: e.message
    end
  end

  # GET /tutors/payment_success/1
  def payment_success
    @tutor = Tutor.find(params[:tutor_id])
    if !params[:checkout_id]
      return redirect_to @tutor, alert: "Error - Checkout ID is expected"
    end
    if (params['error'] && params['error_description'])
      return redirect_to @tutor, alert: "Error - #{params['error_description']}"
    end
    redirect_to @tutor, notice: "Thanks for the payment! You should receive a confirmation email shortly."
  end
end


