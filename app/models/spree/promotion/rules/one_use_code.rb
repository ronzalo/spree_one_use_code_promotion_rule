module Spree
  class Promotion
    module Rules
      class OneUserCode < PromotionRule
        attr_reader :user, :email

        def eligible?(order, options = {})
          @email = order.email

          if email
            completed_orders.blank? || used_codes.blank? || !used_codes.include?(promotion.code)
          else
            false
          end
        end

        private

        def completed_orders
          orders_by_email
        end

        def used_codes
          @used_codes ||= begin
             orders_by_email.collect do |order|
              order.adjustments.promotion.eligible.collect { |p| p.originator.promotion.code } }.flatten.uniq
            end
          end
        end

        def orders_by_email
          Spree::Order.complete.where(email: email)
        end

      end
    end
  end
end
