module Lokka
  module SimpleReach
    def self.registered(app)
      app.get '/admin/plugins/simple_reach' do
        haml :"plugin/lokka-simple_reach/views/index", :layout => :"admin/layout"
      end

      app.put '/admin/plugins/simple_reach' do
        Option.simple_reach_code = params['simple_reach_code']
        flash[:notice] = 'Updated.'
        redirect '/admin/plugins/simple_reach'
      end

      app.before do
        simple_reach_code = Option.simple_reach_code
        if simple_reach_code.present? && ENV['RACK_ENV'] == 'production'
          content_for :footer do
            Option.simple_reach_code
          end
        end
      end
    end
  end
end
