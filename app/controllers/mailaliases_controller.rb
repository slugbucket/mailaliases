class MailaliasesController < ApplicationController
  before_action :set_mailalias, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  # GET /mailaliases
  # GET /mailaliases.json
  def index
    if(params[:search]) then
      search_condition = "%" + params[:search] + "%"
      session[:search] = params[:search]
      session[:page] = nil
    elsif(session[:search])
      search_condition = "%" + session[:search] + "%"
    else
      search_condition = "%"
      session[:search] = nil
    end
    if(params[:page]) then
      session[:page] = params[:page]
    elsif(session[:page])
     nil
     else
      session[:page] = nil
    end
    
    @mailaliases = Mailalias.where('cn LIKE ? OR description LIKE ? OR rfc822mailmember LIKE ?', search_condition, search_condition, search_condition).order('cn asc').paginate :per_page => 100, :page => session[:page]

    session[:mailalias_page] = (session[:page]) ? mailaliases_url+"?page="+session[:page] : mailaliases_url


    respond_to do |format|
      #format.html # index.html.erb
      format.html
      format.xml  { render :xml => @mailaliases }
    end
  end

  # GET /mailaliases/1
  # GET /mailaliases/1.json
  def show
  end

  # GET /mailaliases/new
  def new
    @mailalias = Mailalias.new
    authorize! :new, @mailalias
  end

  # GET /mailaliases/1/edit
  def edit
    authorize! :edit, @mailalias
  end

  # POST /mailaliases
  # POST /mailaliases.json
  def create
    @mailalias = Mailalias.new(mailalias_params)
    authorize! :create, @mailalias

    respond_to do |format|
      if @mailalias.save
        format.html { redirect_to @mailalias, notice: 'Mailalias was successfully created.' }
        format.json { render :show, status: :created, location: @mailalias }
      else
        format.html { render :new }
        format.json { render json: @mailalias.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mailaliases/1
  # PATCH/PUT /mailaliases/1.json
  def update
    authorize! :update, @mailalias
    respond_to do |format|
      if @mailalias.update(mailalias_params)
        format.html { redirect_to @mailalias, notice: 'Mailalias was successfully updated.' }
        format.json { render :show, status: :ok, location: @mailalias }
      else
        format.html { render :edit }
        format.json { render json: @mailalias.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mailaliases/1
  # DELETE /mailaliases/1.json
  def destroy
    authorize! :delete, @mailalias
    @mailalias.destroy
    respond_to do |format|
      format.html { redirect_to mailaliases_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mailalias
      @mailalias = Mailalias.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mailalias_params
      params.require(:mailalias).permit(:cn, :rfc822mailmember, :description)
    end
  def log_update
    log_msg = "id: #{@mailalias.id}\ncn: #{@mailalias.cn}\nrfc822MailMember: #{@mailalias.rfc822mailmember}\ndescrption: #{@mailalias.description}"
    #Rails.logger.debug "DEBUG: #{log_msg}"
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @mailalias.id, :act_action => action_name, :updated_by => current_user.username, :activity => log_msg, :act_tstamp => Time.now)
  end
end
