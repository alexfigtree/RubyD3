module Rubyvis
  module SvgScene
    def self.wedge(scenes, gvs)
      scenes.each_with_index do |s,i|
        next unless s.visible
        fill=s.fill_style
        stroke=s.stroke_style
        next if(fill.opacity==0.0 and stroke.opacity==0.0)
        # /* points */
        
        r1 = s.inner_radius
        r2 = s.outer_radius

        a = (s.angle).abs
        _p=nil
        
        if (a >= 2 * Math::PI) 
          if (r1!=0) 
            _p = "M0,#{r2 }A#{r2},#{r2} 0 1,1 0,#{-r2}A#{r2 },#{r2 } 0 1,1 0,#{r2}M0,#{r1}A#{r1},#{r1} 0 1,1 0,#{-r1}A#{r1},#{r1} 0 1,1 0,#{r1 }Z"
          else 
            _p = "M0,#{r2}A#{r2},#{r2} 0 1,1 0,#{-r2}A#{r2},#{r2} 0 1,1 0,#{r2 }Z"
          end
        else

          sa = [s.start_angle, s.end_angle].min
          ea = [s.start_angle, s.end_angle].max
          c1 = Math.cos(sa)
          c2 = Math.cos(ea)
          s1 = Math.sin(sa)
          s2 = Math.sin(ea)
          if (r1!=0)
            _p = "M#{r2 * c1},#{r2 * s1}A#{r2},#{r2} 0 #{((a < Math::PI) ? "0" : "1")},1 #{r2 * c2},#{r2 * s2}L#{r1 * c2},#{r1 * s2}A#{r1},#{r1} 0 #{((a < Math::PI) ? "0" : "1")},0 #{r1 * c1},#{r1 * s1}Z"
          else 
            _p = "M#{r2 * c1},#{r2 * s1}A#{r2},#{r2} 0 #{((a < Math::PI) ? "0" : "1")},1 #{r2 * c2},#{r2 * s2}L0,0Z"
          end
        end

        e = self.expect(e, "path", {
          "shape-rendering"=> s.shape_rendering,
          "pointer-events"=> s.events,
          "cursor"=> s.cursor,
          "transform"=> s.transform,
          "d"=> _p,
          "fill"=> s.fill,
          "fill-rule"=> s.fill_rule,
          "fill-opacity"=>  s.fill_opacity,
          "stroke"=> s.stroke,
          "stroke-opacity"=> s.stroke_opacity,
          "stroke-width"=> s.stroke_width
        });
		  gvs.add_element(e)
      end
	  gvs
    end

  end
end
