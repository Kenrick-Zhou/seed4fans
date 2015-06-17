require 'nokogiri'
require 'open-uri'

class DusersController < ApplicationController
  before_action :set_duser, only: [:show, :edit, :update, :destroy]

  # GET /dusers
  # GET /dusers.json
  def index
    @dusers = Duser.all
  end

  # GET /dusers/1
  # GET /dusers/1.json
  def show
  end

  def fetch
    @duser = Duser.new
    cookie = params[:cookie]
    start_id =  params[:start_at].to_i
    error_seq = 0
    Thread.new do
      loop do
        did, uid, name, c_follower, c_m_do, c_m_wish, c_m_collect, c_doulist, c_review, error = nil
        did = start_id
        if (Duser.where(["did = ? and uid is not null", did]).any?) |
           (Duser.where(["did = ? and uid is null and name = ? ", did, "豆瓣"]).any?)
          start_id += 1
          next
        end


        begin


          # Fetch and parse HTML document
          #http://www.douban.com/people/56910458/
          #http://www.douban.com/people/35370642/
          doc = Nokogiri::HTML(open("http://www.douban.com/people/#{start_id}/",
          #doc = Nokogiri::HTML(open("http://www.douban.com/people/croath/",
                                    "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/600.6.3 (KHTML, like Gecko) Version/8.0.6 Safari/600.6.3",
                                    "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
                                    "referer" => "http://www.douban.com",
                                    "Cookie" => cookie
                               ))

          name = doc.at_css("head title").content.strip
          puts "name：" + name

          uid = doc.at_css("div#profile div.user-info div.pl").content.split(" ")[0]
          puts "uid: " + uid

          doc.css("div#movie h2 a").each do |a|
            str = a.content
            if str.include? "在看"
              mc = /(\d+)/.match(str)
              c_m_do = mc[0]
              puts "在看：" + c_m_do
            elsif str.include? "想看"
              mc = /(\d+)/.match(str)
              c_m_wish = mc[0]
              puts "想看：" + c_m_wish
            elsif str.include? "看过"
              mc = /(\d+)/.match(str)
              c_m_collect = mc[0]
              puts "看过：" + c_m_collect
            end
          end

          doc.css("p.rev-link a").each do |a|
            str = a.content
            mc = /被(\d+)人关注/.match(str)
            c_follower = mc[1]
            puts "被关注数：" + c_follower
          end

          doc.css("div#doulist span.pl a").each do |a|
            str = a.content
            mc = /(\d+)/.match(str)
            c_doulist = mc[0]
            puts "豆列数：" + c_doulist
          end

          doc.css("div#review h2 span.pl a").each do |a|
            str = a.content
            if str.start_with?("评论")
              mc = /(\d+)/.match(str)
              c_review = mc[0]
              puts "评论数：" + c_review
            end
          end

          puts "seq-head: " + error_seq.to_s
          error_seq = 0
          puts "seq-tail: " + error_seq.to_s

        rescue OpenURI::HTTPError => e
          error_seq += 1 if e.to_s.include?("redirection forbidden")
          error = "HTTPError|: " + e.to_s
          puts error
        rescue NameError => e
          error_seq += 1 if e.to_s.include?("redirection forbidden")
          error = "NameError|: " + e.to_s
          puts error
        rescue StandardError => bang
          error_seq += 1 if bang.to_s.include?("redirection forbidden")
          error = "StandardError|: " + bang.to_s
          puts error
        ensure
          if Duser.where(["did = ? and uid is null", did]).any?
            @duser = Duser.find_by did: did
            @duser.update({
                              did: did,
                              uid: uid,
                              name: name,
                              c_follower: c_follower,
                              c_m_do: c_m_do,
                              c_m_wish: c_m_wish,
                              c_m_collect: c_m_collect,
                              c_doulist: c_doulist,
                              c_review: c_review,
                              error: error
                          })
          else
            @duser = Duser.new({
                                   did: did,
                                   uid: uid,
                                   name: name,
                                   c_follower: c_follower,
                                   c_m_do: c_m_do,
                                   c_m_wish: c_m_wish,
                                   c_m_collect: c_m_collect,
                                   c_doulist: c_doulist,
                                   c_review: c_review,
                                   error: error
                               })
          end
          @duser.save

          puts "============"
          start_id += 1
          sleep 2

          break if error_seq > 5
        end

      end
    end
    puts "thread done!"
  end

  # GET /dusers/new
  def new
    @duser = Duser.new
  end

  # GET /dusers/1/edit
  def edit
  end

  # POST /dusers
  # POST /dusers.json
  def create
    @duser = Duser.new(duser_params)

    respond_to do |format|
      if @duser.save
        format.html { redirect_to @duser, notice: 'Duser was successfully created.' }
        format.json { render :show, status: :created, location: @duser }
      else
        format.html { render :new }
        format.json { render json: @duser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dusers/1
  # PATCH/PUT /dusers/1.json
  def update
    respond_to do |format|
      if @duser.update(duser_params)
        format.html { redirect_to @duser, notice: 'Duser was successfully updated.' }
        format.json { render :show, status: :ok, location: @duser }
      else
        format.html { render :edit }
        format.json { render json: @duser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dusers/1
  # DELETE /dusers/1.json
  def destroy
    @duser.destroy
    respond_to do |format|
      format.html { redirect_to dusers_url, notice: 'Duser was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_duser
      @duser = Duser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def duser_params
      params.require(:duser).permit(:did, :uid, :name, :c_follower, :c_m_do, :c_m_wish, :c_m_collect, :c_doulist, :c_review, :error)
    end
end
