class EmailsController < ApplicationController
  before_action :set_email, only: %i[ show edit update destroy ]

  # GET /emails or /emails.json
  def index
    @emails = Email.all
  end

  # GET /emails/1 or /emails/1.json
  def show
    @email = Email.find(params[:id])
    if @email.read == false
      @email.update(read: !@email.read)
    end

    # @email.update
    puts '*'*50
    puts @email.read
    puts '*'*50

    respond_to do |format|
        format.html { redirect_to emails_path}
        # format.json { render :show, status: :created, location: @email }
        format.js{}
    end
  end

  # GET /emails/new
  def new
    @email = Email.new
  end

  # GET /emails/1/edit
  def edit
  end

  # POST /emails or /emails.json
  def create
    @email = Email.create(object: Faker::Book.title,body: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4), read: false)

    respond_to do |format|
      if @email.save
        format.html { redirect_to emails_path}
        # format.json { render :show, status: :created, location: @email }
        format.js{}
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end

    
  end

  # PATCH/PUT /emails/1 or /emails/1.json
  def update
    @email = Email.find(params[:id])
    @email.update(read: !@email.read)

    respond_to do |format|
        format.html { redirect_to emails_path, notice: "Email was successfully updated." }
        format.js {}
    end
  end

  # DELETE /emails/1 or /emails/1.json
  def destroy
    @email.destroy

    respond_to do |format|
      format.html { redirect_to emails_url, notice: "Email was successfully destroyed." }
      format.js {}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def email_params
      params.require(:email).permit(:object, :body)
    end
end
