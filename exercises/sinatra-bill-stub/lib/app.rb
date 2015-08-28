require 'sinatra'
require 'json'

set :show_exceptions, :after_handler

class App < Sinatra::Base

  FROM_DATE = '01-08-2015'
  TO_DATE = '31-08-2015'

  BILL = {
      statement: {
          generated: '2015-01-11',
          due: '2015-01-25',
          period: {
              from: FROM_DATE,
              to: TO_DATE
          }
      },
      total: 136.03,
      package: {
          subscriptions: [
              {type: 'tv', name: 'Variety with Movies HD', cost: 50.00},
              {type: 'talk', name: 'Sky Talk Anytime', cost: 5.00},
              {type: 'broadband', name: 'Fibre Unlimited', cost: 16.40}
          ],
          total: 71.40
      },
      callCharges: {
          calls: [
              {called: '07716393769', duration: '00:23:03', cost: 2.13},
              {called: '07716393999', duration: '00:08:11', cost: 1.22},
              {called: '07716393888', duration: '00:15:03', cost: 1.87}
          ],
          total: 5.22
      },
      skyStore: {
          rentals: [
              {title: '50 Shades of Grey', cost: 4.99}
          ],
          buyAndKeep: [
              {title: 'Thats what she said', cost: 9.99},
              {title: 'Broke back mountain', cost: 9.99}
          ],
          total: 24.97
      }
  }

  get '/bill' do
    case 0[params[:from], params[:to]]
      when [FROM_DATE, TO_DATE]
        JSON.generate(ids: %w{10000002})
      else
        JSON.generate(ids: %w{10000001 10000002})
    end
  end

  get '/bill/:bill_id' do
    case params[:bill_id]
      when '10000002'
        JSON.generate(BILL)
      else
        404
    end
  end
end