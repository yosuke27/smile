class MicropostsController < ApplicationController
#  before_action :set_micropost, only: [:show, :edit, :update, :destroy]

  # GET /microposts
  # GET /microposts.json
  def index
    redirect_to '/home'
    @microposts = Micropost.all
  end

  def monthly
    if not logged_in?
      redirect_to '/'
    end
  end
  
  def weekly
    if not logged_in?
      redirect_to '/'
    end
    # today or selected date
    target_date = to_date_or_now params[:from];

    # create 1 week list
    sunday = last_sunday_datecode target_date
    saturday = next_saturday_datecode target_date
    @from_datecode = sunday.to_time
    @to_datecode = saturday.to_time
    
    week_array = Array.new
    tmp_date = sunday
    while tmp_date <= saturday do
      week_array.push(tmp_date)
      tmp_date = to_datecode tmp_date.to_time.days_ago(-1)
    end
    
    @days = week_array.to_a

    # create onechance_meter 
    datecode = to_datecode now
    today_posts = Micropost.where("datecode = ?", datecode)
    today_posts_count = today_posts.count
    is_onechance = true
    today_posts_onechance = today_posts.where(is_onechance: is_onechance).count
    @onechance_percent = (today_posts_onechance.to_f/today_posts_count.to_f*100).to_s

    # users 
    @users = User.all.to_a.sort{ |a, b| b.microposts.last.updated_at <=> a.microposts.last.updated_at }
    

    @prev_date = to_datecode target_date.days_ago(7)
    @next_date = to_datecode target_date.days_ago(-7)
    @posts_weekly = Micropost.where("datecode >= ? and datecode <= ?", sunday, saturday).to_a
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
    
    datecode = to_datecode now    
    user = current_user
    item = micropost_params;
    
    if item[:content].nil?
      return
    end
    
    if item[:mood].nil?
      return
    end

    item[:datecode] = datecode
    item[:user_id] = user.id
    target_item = user.microposts.find_by(datecode: datecode)
    if target_item.nil?
      @micropost = Micropost.new(item)
    else
      target_item.update(content: item[:content], mood: item[:mood], is_onechance: item[:is_onechance])
      @micropost = target_item
    end

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
