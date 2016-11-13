class MicropostsController < ApplicationController
#  before_action :set_micropost, only: [:show, :edit, :update, :destroy]

  # GET /microposts
  # GET /microposts.json
  def index
    redirect_to '/home'
    @microposts = Micropost.all
  end
  
  def weekly
    if not logged_in?
      redirect_to '/'
    end
  
    sunday = last_sunday_datecode to_date_or_now params[:from]
    saturday = next_saturday_datecode to_date_or_now params[:from]
    @users = User.all
    @from_datecode = sunday.to_time
    @to_datecode = saturday.to_time
    @days = (sunday..saturday).to_a
    datecode = to_datecode now
    is_onechance = true
    todaypost = Micropost.where("datecode = ?", datecode).count
    todaypost_onechance = Micropost.where("datecode = ? and is_onechance = ?", datecode, is_onechance).count
    @onechance_percent = (todaypost_onechance.to_f/todaypost.to_f*100).to_s
  end
  

  # GET /microposts/1
  # GET /microposts/1.json
  def show
    redirect_to '/calender/weekly'
  end

  # GET /microposts/new
  def new
    redirect_to '/calender/weekly'
    @micropost = Micropost.new
  end

  # GET /microposts/1/edit
#  def edit
#  end

  # POST /microposts
  # POST /microposts.json
  def create
    if not logged_in?
      redirect_to '/'
    end
    
    user = current_user
    item = micropost_params;
    item[:datecode] = to_datecode now
    item[:user_id] = user.id
    @micropost = Micropost.new(item)

    respond_to do |format|
      if @micropost.save
        format.html { redirect_to @micropost, notice: 'Micropost was successfully created.' }
        format.json { render :show, status: :created, location: @micropost }
      else
        format.html { render :new }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /microposts/1
  # PATCH/PUT /microposts/1.json
#  def update
#    respond_to do |format|
#      if @micropost.update(micropost_params)
#        format.html { redirect_to @micropost, notice: 'Micropost was successfully updated.' }
#        format.json { render :show, status: :ok, location: @micropost }
#      else
#        format.html { render :edit }
#        format.json { render json: @micropost.errors, status: :unprocessable_entity }
#      end
#    end
#  end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
#  def destroy
#    @micropost.destroy
#    respond_to do |format|
#      format.html { redirect_to microposts_url, notice: 'Micropost was successfully destroyed.' }
#      format.json { head :no_content }
#    end
#  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def micropost_params
      params.require(:micropost).permit(:datecode, :user_id, :content, :mood, :is_onechance)
    end
end
