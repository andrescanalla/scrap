class ArchivosController < ApplicationController
  require 'open-uri'
  require 'watir'
  require 'nokogiri'  
  require 'koala'
  require 'fileutils'

  def cerrar
  	@albumv=params[:carpeta]  
  	if $browser.windows.count > 1
  	$browser.windows.last.use.close  
  	@ope="ce"
  	else
  	@ope ="ts"
  	end	
  	temp = "public/images/temp"
  	
  	redirect_to :controller => "archivos", :action=>"listar_archivos", :temp=>temp , :albumv=>@albumv, :ope=>@ope;
  end

  def delete
  nom = params[:nombre] 
  album=params[:albb]  
  @albumv=params[:albb]  
  if (album=="cbeba")
		directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_bebas"
		directorior = "public/images/carters_bebas"
	elsif (album=="cbebe")
		directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_bebes"
		directorior = "public/images/carters_bebes"
	elsif (album=="cnena")
		directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_nenas"
		directorior = "public/images/carters_nenas"
	elsif (album=="cnene")
		directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_nenes"
		directorior = "public/images/carters_nenes"
	elsif (album=="hnena")
		directorio = "c:/xampp/htdocs/tienda/public/images/productos/hym_nenas"
		directorior = "public/images/hym_nenas"
	elsif (album=="hnene")
		directorio = "c:/xampp/htdocs/tienda/public/images/productos/hym_nenes"
		directorior = "public/images/hym_nenes"
	else
		directorio = "c:/xampp/htdocs/tienda/public/images/productos/skyp_hop"
		directorior = "public/images/skyp_hop" 		
  end

  temp = "public/images/temp"
  @temp = "/images/temp/"
  @archivos=[]
  @archivost=[]
  	
  #byebug	
  path_deletet ="public/images/temp/"
  FileUtils.remove_file(path_deletet + nom, force = false)
  FileUtils.remove_file(directorior +"/"+ nom, force = false)
  @architemp = Dir.entries(temp);
  render :listar_archivos;

  end

  def deletetemp
  	files = Dir.entries("public/images/temp")
  	files = files[2,800]
  	path_delete ="public/images/temp/"  	  	
  	files.each do |a|  		
  		FileUtils.remove_file(path_delete + a, force = false)
  	end
  	temp = "public/images/temp"
	@temp = "/images/temp/"
	@archivos=[]
	@archivost=[]
  	@architemp = Dir.entries(temp);
  	render :listar_archivos;
  end

  def subir
  	@albumv=params[:carpeta]  
  	filespath = []
  	log = []
  	if @albumv=="cbeba"	
  	my_album_id = "1474268852893493"
  	directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_bebas"
  	elsif @albumv=="cbebe"
  	my_album_id ="1473359842984394"
  	directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_bebes"
  	elsif @albumv=="cnena"
  	my_album_id ="1476399469347098"
  	directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_nenas"
  	elsif @albumv=="cnene"
  	my_album_id ="1475944139392631"
  	directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_nenes"
  	elsif @albumv=="hnena"
  	my_album_id ="1472453289741716"
  	directorio = "c:/xampp/htdocs/tienda/public/images/productos/hym_nenas"
  	elsif @albumv=="hnene"
  	my_album_id ="1472916719695373"
  	directorio = "c:/xampp/htdocs/tienda/public/images/productos/hym_nenes"
  	elsif @albumv=="skyp"
  	my_album_id ="1837283549925353"  
  	directorio = "c:/xampp/htdocs/tienda/public/images/productos/skyp_hop"		
  	end

  	temp = "public/images/temp"
  	files = Dir.entries(temp)
  	path_delete ="public/images/temp/"
  	files = files[2,800]
  	nfiles = files.count
  	nfilest = files.count
  	path = "c:/xampp/htdocs/scrap/scrap/public/images/temp/"
  	files_bath = files.first(20)
  	
  	#@user_graph = Koala::Facebook::API.new()  		
  	#page_token = @user_graph.get_page_access_token("1470907659896279")
  	#profileg = @page_graph.get_object("me")  
  	
  	
  	while nfiles > 0 
	  	@page_graph = Koala::Facebook::API.new()	
	  	files_bath.each do |a|
	  		filespath = path + a  		
	  		log<<@page_graph.put_picture(filespath, {:caption => a[0,6] }, my_album_id)
	  		#log<<@page_graph.put_picture(filespath, {:caption => a[0,6] }, "1623259824405501")
	  		
	  	end	

	  	files_bath.each do |a|
	  		src = path + a 
	  		dest = directorio+"/"+a
	  	FileUtils.copy_file(src, dest, preserve = false, dereference = true)
	  	end	

	  	#files_bath.each do |a|
	  		#FileUtils.remove_file(path + a, force = false)
	  	#end

	  	#byebug
	  	filesw = files[log.count, 800]
	  	if !files.nil?
	  		files_bath = filesw.first(20)
	    end
	  	nfiles=nfilest-log.count
	  	
  	end
  	logsub = log.count
  	@ope="su"
  	@archivos=[]
	@archivost=[]
	@architemp = Dir.entries(temp);	
	@temp = "/images/temp/"
  	redirect_to :controller => "archivos", :action=>"listar_archivos", :temp=>temp , :albumv=>@albumv, :ope=>@ope, :logsub=>logsub;
  	
  	
  
  end

  
  def abrir_brow
  		$browser= Watir::Browser.new(:chrome)
  end

  
  def bajar_arch
  		album=params[:carpeta];
  		temp = "public/images/temp";
  		if (album=="cbeba")
	  		directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_bebas"
	  		directorior = "public/images/carters_bebas"
  		elsif (album=="cbebe")
  			directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_bebes"
	  		directorior = "public/images/carters_bebes"
	  	elsif (album=="cnena")
  			directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_nenas"
	  		directorior = "public/images/carters_nenas"
	  	elsif (album=="cnene")
  			directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_nenes"
	  		directorior = "public/images/carters_nenes"
	  	elsif (album=="hnena")
  			directorio = "c:/xampp/htdocs/tienda/public/images/productos/hym_nenas"
	  		directorior = "public/images/hym_nenas"
	  	elsif (album=="hnene")
  			directorio = "c:/xampp/htdocs/tienda/public/images/productos/hym_nenes"
	  		directorior = "public/images/hym_nenes"
	  	else
  			directorio = "c:/xampp/htdocs/tienda/public/images/productos/skyp_hop"
	  		directorior = "public/images/skyp_hop" 		
		end
  		
		if(Dir.entries(temp).count==2)
	  		archivo = Dir.entries(directorio);  		 
	  		arch=archivo.last(2)
		  		arch.each do |a|
		  		 	$arch1=a[0..4]
		  		end
	  		arch2=Integer($arch1)+1
	  		cod=arch2.to_s+"-"
  		else
  			archivo = Dir.entries(temp);  		 
  			arch=archivo.last(2)
		  		arch.each do |a|
		  		 	$arch1=a[0..4]
		  		end
	  		arch2=Integer($arch1)+1
	  		cod=arch2.to_s+"-"
	  	end
	  	if $browser.windows.count > 1
	  		$browser.windows.last.use
	  		$doc = Nokogiri::XML.parse($browser.html)
	  		if(album=="hnena" || album=="hnene")
	  			img=$browser.windows.last.url
	  			na=img.split("=").last
	  			nam=na+".jpg"
	  			$img="http:"+$doc.css('[class="fullscreen"]')[1].attr('href')
	  			$imgr=$img
	  		else
			  	
			  	$img0=$doc.css('[class="primary-image"]').attr('src').value
			  	$imgr=$img0[0..-2]
			  	$img=$img0[0..-4]+"2000"
			  	#na=$img0.split("/").last
			  	#nam=na[0..-8]

			  	$imgaa=$browser.windows.last.url
			  	$imgab=$imgaa.split("/")[4]
			  	$imgabc=$imgab.split(".html").first
			  	nam = $imgabc.split("_").last+".jpg"
			  	if nam[0..1]=="OB" || nam[0..1]=="OG"
		  			nam = nam[2..-1]
		  		end	

			 end
		  	name=cod+nam
		  	
		  	$patht = File.join(temp, name);
		  	open($patht, 'wb') do |file|
			  file << open($img).read
			end
			
		  	#$path = File.join(directorio, name);
		    $pathr = File.join(directorior, name);
		  	open($pathr, 'wb') do |file|
			    file << open($imgr).read
			end
			ope ="t"
			$browser.windows.last.use.close
		else
		ope ="ts"
		end
		#open($path, 'wb') do |file|
		#  file << open($img).read
		#end
		ult=Dir.entries(temp).last
		
		#render
		redirect_to :controller => "archivos", :action=>"listar_archivos", :temp=>temp , :ult=>ult , :directorio=>directorio, :directorior=>directorior, :albumv=>album, :ope=>ope;
	end

  def listar_archivos	 
	 @ope=params[:ope]
	 @ult=params[:ult]
	 @albumv=params[:albumv]	 
	 temp = "public/images/temp"	 
	 @temp = "/images/temp/"
	 @archivost=[" "]
	 @archivost=[]
	 @archivos=[" "]
	 @archivos=[]
	  if params[:albumv]
	   directorio = params[:directorio]
	   if !params[:directorior].nil?
	   		@alb = params[:directorior][6..-1]+"/"
	   end		
 	 else 
 	   	@alb="/images/carters_bebas/"
	 	directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_bebas"
	 end
	 	@architemp = Dir.entries(temp);	 	
	  if !params[:directorio].nil?  
	   @archivo = Dir.entries(directorio);
	  end  	    
  end

  def check
  	album=params[:carpeta]
  	if (album=="cbeba")
	  		directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_bebas"
	  		directorior = "public/images/carters_bebas"
  		elsif (album=="cbebe")
  			directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_bebes"
	  		directorior = "public/images/carters_bebes"
	  	elsif (album=="cnena")
  			directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_nenas"
	  		directorior = "public/images/carters_nenas"
	  	elsif (album=="cnene")
  			directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_nenes"
	  		directorior = "public/images/carters_nenes"
	  	elsif (album=="hnena")
  			directorio = "c:/xampp/htdocs/tienda/public/images/productos/hym_nenas"
	  		directorior = "public/images/hym_nenas"
	  	elsif (album=="hnene")
  			directorio = "c:/xampp/htdocs/tienda/public/images/productos/hym_nenes"
	  		directorior = "public/images/hym_nenes"
	  	else
  			directorio = "c:/xampp/htdocs/tienda/public/images/productos/skyp_hop"
	  		directorior = "public/images/skyp_hop" 		
	end
	if $browser.windows.count > 1
		$browser.windows.last.use
		$doc = Nokogiri::XML.parse($browser.html)
		if(album=="hnena" || album=="hnene")
			img=$browser.windows.last.url
			naa=img.split("=").last
			$namc=naa+".jpg"
			$img="http:"+$doc.css('[class="fullscreen"]')[1].attr('href')
			$imgr=$img
			@imgr=$imgr
			@nom=$namc
		else		  	
	  	$img0=$doc.css('[class="primary-image"]').attr('src').value
	  	@imgr=$img0[0..-2]
	  	#$img=$img0[0..-4]+"2000"
	  	#nab=$img0.split("/").last
	  	#$namc=nab[0..-8]

		  	$imgaa=$browser.windows.last.url
		  	$imgab=$imgaa.split("/")[4]
		  	$imgabc=$imgab.split(".html").first
		  	$namc=$imgabc.split("_").last+".jpg"
		  	if $namc[0..1]=="OB" || $namc[0..1]=="OG"
		  		$namc=$namc[2..-1]
		  		
		  	end	
		  	@nom=$namc
		  	
	 	end
			@archivos=[""]
			@albumv=album
			@alb = directorior[6..-1]+"/"
			@archivos=[]
			@archivost=[]
	  		@buscapro=Dir.entries(directorio)
	  		@buscapro.each do |a|
	  			$na=a[6..-1]
	  			if $na==$namc
	  				@archivos<<a
	  			
	  			end
	  		end
	  		 temp = "public/images/temp"
	  		  @temp = "/images/temp/"
	  		@buscapro=Dir.entries(temp)
	  		@buscapro.each do |a|
	  			$na=a[6..-1]
	  			if $na==$namc
	  				@archivost<<a
	  			end
	  		end 
	  	@ope="ch"
	else
		@ope="ts"
		@albumv=album
		@archivos=[]
		temp = "public/images/temp"
		@temp = "/images/temp/"
	end

	@architemp = Dir.entries(temp);
	#@architemp1 = @architemp.delete_at(0);  
	#@architemp2 = @architemp1; 
	
	
	render :listar_archivos;
	#byebug
	#.where(codebar:  @i_codebar_final).first
	# if @buscapro.blank?
  end

end
