class SubirproductoController < ApplicationController
  require 'open-uri'
  require 'watir'
  require 'nokogiri'  
  require 'koala'
  require 'fileutils'
  require 'Temp'

  def edit
	  @idEdit = params[:id]	
	  @nom = params[:name]
	  @albumv=params[:albb]
	  @archivos=[]
  	  @archivost=[]
	  Temp.find(@idEdit).update(namen: params[:name]) 
	  @architemp = Temp.all
	  respond_to do |format|
	      format.html {  render :subir_producto }
	      format.json { head :no_content }
	      format.js   { render :layout => false }
	  end
  end

  def cerrar
  	@albumv=params[:carpeta]  
  	if $browser.windows.count > 1
  	$browser.windows.last.use.close  
  	@ope="ce"
  	else
  	@ope ="ts"
  	end	
  	#temp = "public/images/temp"
  	
  	redirect_to :controller => "subirproducto", :action=>"subir_producto",  :albumv=>@albumv, :ope=>@ope;
  end

  def delete
  nom = params[:id] 
  album=params[:albb]  
  @albumv=params[:albb]  
  #if (album=="cbeba")
#		directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_bebas"
#		directorior = "public/images/carters_bebas"
#	elsif (album=="cbebe")
#		directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_bebes"
#		directorior = "public/images/carters_bebes"
#	elsif (album=="cnena")
#		directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_nenas"
#		directorior = "public/images/carters_nenas"
#	elsif (album=="cnene")
#		directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_nenes"
#		directorior = "public/images/carters_nenes"
#	elsif (album=="hnena")
#		directorio = "c:/xampp/htdocs/tienda/public/images/productos/hym_nenas"
#		directorior = "public/images/hym_nenas"
#	elsif (album=="hnene")
#		directorio = "c:/xampp/htdocs/tienda/public/images/productos/hym_nenes"
#		directorior = "public/images/hym_nenes"
#	else
#		directorio = "c:/xampp/htdocs/tienda/public/images/productos/skyp_hop"
#		directorior = "public/images/skyp_hop" 		
#  end
#
  #temp = "public/images/temp"
  #@temp = "/images/temp/"
  @archivos=[]
  @archivost=[]
  
  Temp.find(nom).delete 
  

  #byebug	
  #path_deletet ="public/images/temp/"
  #FileUtils.remove_file(path_deletet + nom, force = false)
  #FileUtils.remove_file(directorior +"/"+ nom, force = false)
  @architemp = Temp.all
  render :subir_producto;

  end

  def deletetemp
  	#files = Dir.entries("public/images/temp")
  	#files = files[2,800]
  	#path_delete ="public/images/temp/"  	  	
  	#files.each do |a|  		
  	#	FileUtils.remove_file(path_delete + a, force = false)
  	#end
  	#temp = "public/images/temp"
	#@temp = "/images/temp/"
	Temp.delete_all
	@archivos=[]
	@archivost=[]
  	@architemp = Temp.all
  	render :subir_producto;
  end

  def subir
  	@albumv=params[:carpeta]  
  	filespath = []
  	log = []
  	if @albumv=="cbeba"	
  	my_album_id = "1474268852893493"
  	#directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_bebas"
  	elsif @albumv=="cbebe"
  	my_album_id ="1473359842984394"
  	#directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_bebes"
  	elsif @albumv=="cnena"
  	my_album_id ="1476399469347098"
  	#directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_nenas"
  	elsif @albumv=="cnene"
  	my_album_id ="1475944139392631"
  	#directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_nenes"
  	elsif @albumv=="hnena"
  	my_album_id ="1472453289741716"
  	#directorio = "c:/xampp/htdocs/tienda/public/images/productos/hym_nenas"
  	elsif @albumv=="hnene"
  	my_album_id ="1472916719695373"
  	#directorio = "c:/xampp/htdocs/tienda/public/images/productos/hym_nenes"
  	elsif @albumv=="skip"
  	my_album_id ="1837283549925353"  
  	#directorio = "c:/xampp/htdocs/tienda/public/images/productos/skyp_hop"		
  	end

  	#temp = "public/images/temp"
  	#files = Dir.entries(temp)
  	files = Temp.all

  	#path_delete ="public/images/temp/"
  	#files = files[2,800]
  	nfiles = files.count
  	nfilest = files.count
  	#path = "c:/xampp/htdocs/scrap/scrap/public/images/temp/"
  	files_bath = files.first(10)
  	
  	#@user_graph = Koala::Facebook::API.new()  		
  	#page_token = @user_graph.get_page_access_token("1470907659896279")
  	#profileg = @page_graph.get_object("me")  
  	
  	
  	while nfiles > 0 
	  	@page_graph = Koala::Facebook::API.new()	
	  	files_bath.each do |a|
	  		filespath = a.imagen
	  		filespath = filespath.gsub(' ', '%20')
	  		codeCap = a.code + a.namen				
	  		
	  		log<<@page_graph.put_picture(filespath, {:caption => codeCap }, my_album_id)
	  		#log<<@page_graph.put_picture(filespath, {:caption => codeCap }, "1623259824405501")
	  		pubId = log.last["id"]
	  		dirDataFace ="https://graph.facebook.com/v2.11/"+pubId+"?access_token="+$tok_tienda+"&fields=link,picture,name";
   			dataFace = open(dirDataFace)
   			data = JSON.parse dataFace.read
   			#$tools = json_decode(dataFace);   
   			#$tools = json_decode(file_get_contents($apialbum));   

	  		
		  	#end	

		  	#files_bath.each do |a|
	  		nuevo=Subirproducto.new
	  		nuevo.idfacebook = pubId
	  		nuevo.idalbum = my_album_id
	  		nuevo.code = a.code 
	  		nuevo.album = @albumv
	  		nuevo.foto = a.imagen
	  		nuevo.pic = data["picture"]
	  		nuevo.link = data["link"]
	  		nuevo.style = a.style
	  		nuevo.name= data["name"]
	  		nuevo.save
	  		
	  		a.delete
	  		#byebug

	  		#src = path + a 
	  		#dest = directorio+"/"+a
	  		#FileUtils.copy_file(src, dest, preserve = false, dereference = true)
	  	end	

	  	#files_bath.each do |a|
	  		#FileUtils.remove_file(path + a, force = false)
	  	#end

	  	#byebug
	  	files=Temp.all
	  	files_bath = files.first(10)
	  	nfiles=files.count
	  	#filesw = files[log.count, 800]
	  	#if !files.nil?
	  		#files_bath = filesw.first(2)
	    #end
	  	#nfiles=nfilest-log.count
	  	
  	end
  	logsub = log.count
  	@ope="su"
  	@archivos=[]
	@archivost=[]
	#@architemp = Dir.entries(temp);
	@architemp = Temp.all;	
	#@temp = "/images/temp/"
  	redirect_to :controller => "subirproducto", :action=>"subir_producto", :albumv=>@albumv, :ope=>@ope, :logsub=>logsub;
  	
  	
  
  end

  
  def abrir_brow
  		$browser= Watir::Browser.new(:chrome)
  end

  
  def bajar_arch
  		album=params[:carpeta];
  		foto=params[:foto];
  		temp = Temp.all
  		#temp = "public/images/temp";
  		lista = Subirproducto.where("album = ?", album)
  		#if (album=="cbeba")
	  	#	
	  	#	#directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_bebas"
	  	#	#directorior = "public/images/carters_bebas"
  		#elsif (album=="cbebe")
  		#	
  		#	directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_bebes"
	  	#	directorior = "public/images/carters_bebes"
	  	#elsif (album=="cnena")
  		#	lista = Facebook.where("album = ?", album)
  		#	directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_nenas"
	  	#	directorior = "public/images/carters_nenas"
	  	#elsif (album=="cnene")
  		#	directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_nenes"
	  	#	directorior = "public/images/carters_nenes"
	  	#elsif (album=="hnena")
  		#	directorio = "c:/xampp/htdocs/tienda/public/images/productos/hym_nenas"
	  	#	directorior = "public/images/hym_nenas"
	  	#elsif (album=="hnene")
  		#	directorio = "c:/xampp/htdocs/tienda/public/images/productos/hym_nenes"
	  	#	directorior = "public/images/hym_nenes"
	  	#else
  		#	directorio = "c:/xampp/htdocs/tienda/public/images/productos/skyp_hop"
	  	#	directorior = "public/images/skyp_hop" 		
		#end
  		
		if(temp.count==0)
	  		#archivo = Dir.entries(directorio);  		 
	  		#arch=archivo.last(2)
	  		arch=lista.order(:created_at).last
		  		#arch.each do |a|
		  		 	#$arch1=a[0..4]
		  		 	$arch1=arch.code
		  		#end
	  		arch2=Integer($arch1)+1
	  		#cod=arch2.to_s+"-"
	  		cod=arch2.to_s
  		else
  			#archivo = Dir.entries(temp);  		 
  			#arch=archivo.last(2)
  			arch=temp.order(:created_at).last
		  		#arch.each do |a|
		  		 	#$arch1=a[0..4]
		  		 	$arch1=arch.code
		  		#end
	  		arch2=Integer($arch1)+1
	  		#cod=arch2.to_s+"-"
	  		cod=arch2.to_s
	  	end
	  	if $browser.windows.count > 1
	  		$browser.windows.last.use
	  		$doc = Nokogiri::XML.parse($browser.html)
	  		if(album=="hnena" || album=="hnene")
	  			img=$browser.windows.last.url
	  			#na=img.split("=").last //version vieja de la web
	  			na=img.split(".")[3]
	  			#nam=na+".jpg"
	  			nam=na
	  			#$img="http:"+$doc.css('[class="fullscreen"]')[1].attr('href') //version vieja de la web
				
			
			
			if (foto=="auto")
				if($doc.css('[class="product-detail-thumbnail-image"]').count>1)
					$img="http:"+$doc.css('[class="product-detail-thumbnail-image"]')[1].attr('src')
				elsif ($doc.css('[class="product-detail-thumbnail-image"]').count==0)
					$img="http:"+$doc.css("div[class='product-detail-main-image-container']").css("img").attr('src').value
				else
					$img="http:"+$doc.css('[class="product-detail-thumbnail-image"]').attr('src').value
				end
			elsif (foto=="1")
				$img="http:"+$doc.css("div[class='product-detail-main-image-container']").css("img").attr('src').value
			elsif (foto=="2")
			  	if($doc.css('[class="product-detail-thumbnail-image"]').count==0)
			  		
			  		$img=""
			  	else
					if($doc.css('[class="product-detail-thumbnail-image"]').count>1)
						$img="http:"+$doc.css('[class="product-detail-thumbnail-image"]')[0].attr('src')
					else
						$img="http:"+$doc.css('[class="product-detail-thumbnail-image"]').attr('src').value
					end
				end	
			elsif (foto=="3")
				if($doc.css('[class="product-detail-thumbnail-image"]').count<2)
			  		
			  		$img=""
			  	else
					$img="http:"+$doc.css('[class="product-detail-thumbnail-image"]')[1].attr('src')
				end	
			else
				if($doc.css('[class="product-detail-thumbnail-image"]').count<3)
			  		
			  		$img=""
			  	else
					$img="http:"+$doc.css('[class="product-detail-thumbnail-image"]')[2].attr('src')
				end
			end					
				

	  			
	  			

	  			$imgr=$img
	  		else
			  	
			  	#$img0=$doc.css('[class="primary-image"]').attr('src').value
			  	$img=$doc.css('[class="primary-image"]').attr('src').value
			  	#$imgr=$img0[0..-2]
			  	#$img=$img0[0..-2]
			  	#$img=$img0[0..-4]+"2000"
			  	#na=$img0.split("/").last
			  	#nam=na[0..-8]

			  	$imgaa=$browser.windows.last.url
			  	$imgab=$imgaa.split("/")[4]
			  	$imgabc=$imgab.split(".html").first
			  	#nam = $imgabc.split("_").last+".jpg"
			  	nam = $imgabc.split("_").last
			  	if nam[0..1]=="OB" || nam[0..1]=="OG"
		  			nam = nam[2..-1]
		  		end	

			 end
		  	#name=cod+nam
		  	
		  	#$patht = File.join(temp, name);
		  	#open($patht, 'wb') do |file|
			#  file << open($img).read
			#end
			
		  	#$path = File.join(directorio, name);
		    #$pathr = File.join(directorior, name);
		  	#open($pathr, 'wb') do |file|
			#    file << open($imgr).read
			#end
			nuevoTemp = Temp.new
			nuevoTemp.code = cod
			nuevoTemp.style = nam
			nuevoTemp.imagen = $img
			#nuevoTemp.pic = $imgr
			nuevoTemp.save
			ope ="t"
			$browser.windows.last.use.close
		else
		ope ="ts"
		end
		#open($path, 'wb') do |file|
		#  file << open($img).read
		#end
		ult = Temp.last
		
		#render
		redirect_to :controller => "subirproducto", :action=>"subir_producto", :temp=>temp , :ult=>ult ,  :lista=>lista, :albumv=>album, :ope=>ope;
	end

  def subir_producto	 
	 @ope=params[:ope]
	 #@ult=params[:ult]
	 @ult= Temp.order(:created_at).last
	 #byebug
	 @albumv=params[:albumv]	 
	 #temp = "public/images/temp"	 
	 #@temp = "/images/temp/"
	 @archivost=[" "]
	 @archivost=[]
	 @archivos=[" "]
	 @archivos=[]
	  if params[:albumv]
	  	 @archivo = Subirproducto.where("album = ?", @albumv)
	  end
	  #if params[:albumv] 
	   #directorio = params[:directorio]
	   #if !params[:directorior].nil?
	   		#@alb = params[:directorior][6..-1]+"/"
	   #end		
 	 #else 
 	   	#@alb="/images/carters_bebas/"
	 	#directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_bebas"
	 #end
	 	@architemp = Temp.all;	 	
	  #if !params[:directorio].nil?  
	   #@archivo = Dir.entries(directorio);
	  #end  	    
  end

  def check
  	album=params[:carpeta]
  	foto=params[:foto]
  	lista = Subirproducto.where("album = ?", album)
  	#if (album=="cbeba")
	#  		directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_bebas"
	#  		directorior = "public/images/carters_bebas"
  	#	elsif (album=="cbebe")
  	#		directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_bebes"
	#  		directorior = "public/images/carters_bebes"
	#  	elsif (album=="cnena")
  	#		directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_nenas"
	#  		directorior = "public/images/carters_nenas"
	#  	elsif (album=="cnene")
  	#		directorio = "c:/xampp/htdocs/tienda/public/images/productos/carters_nenes"
	#  		directorior = "public/images/carters_nenes"
	#  	elsif (album=="hnena")
  	#		directorio = "c:/xampp/htdocs/tienda/public/images/productos/hym_nenas"
	#  		directorior = "public/images/hym_nenas"
	#  	elsif (album=="hnene")
  	#		directorio = "c:/xampp/htdocs/tienda/public/images/productos/hym_nenes"
	#  		directorior = "public/images/hym_nenes"
	#  	else
  	#		directorio = "c:/xampp/htdocs/tienda/public/images/productos/skyp_hop"
	#  		directorior = "public/images/skyp_hop" 		
	#end
	if $browser.windows.count > 1
		$browser.windows.last.use
		$doc = Nokogiri::XML.parse($browser.html)
		if(album=="hnena" || album=="hnene")
			img=$browser.windows.last.url
			@title=$doc.css('[class="primary product-item-headline"]').text
			#naa=img.split("=").last //version anterior de la web
			naa=img.split(".")[3]
			@fot=""
			#$namc=naa+".jpg"
			$namc=naa
			if (foto=="auto")
				if($doc.css('[class="product-detail-thumbnail-image"]').count>1)
					$img="http:"+$doc.css('[class="product-detail-thumbnail-image"]')[1].attr('src')
				elsif ($doc.css('[class="product-detail-thumbnail-image"]').count==0)
					$img="http:"+$doc.css("div[class='product-detail-main-image-container']").css("img").attr('src').value
				else
					$img="http:"+$doc.css('[class="product-detail-thumbnail-image"]').attr('src').value
				end
			elsif (foto=="1")
				$img="http:"+$doc.css("div[class='product-detail-main-image-container']").css("img").attr('src').value
			elsif (foto=="2")
			  	if($doc.css('[class="product-detail-thumbnail-image"]').count==0)
			  		@fot="true"
			  		$img=""
			  	else
					if($doc.css('[class="product-detail-thumbnail-image"]').count>1)
						$img="http:"+$doc.css('[class="product-detail-thumbnail-image"]')[0].attr('src')
					else
						$img="http:"+$doc.css('[class="product-detail-thumbnail-image"]').attr('src').value
					end
				end	
			elsif (foto=="3")
				if($doc.css('[class="product-detail-thumbnail-image"]').count<2)
			  		@fot="true"
			  		$img=""
			  	else
					$img="http:"+$doc.css('[class="product-detail-thumbnail-image"]')[1].attr('src')
				end	
			else
				if($doc.css('[class="product-detail-thumbnail-image"]').count<3)
			  		@fot="true"
			  		$img=""
			  	else
					$img="http:"+$doc.css('[class="product-detail-thumbnail-image"]')[2].attr('src')
				end
			end					
					

						

				

			#$img="http:"+$doc.css('[class="fullscreen"]')[1].attr('href') //version anterior de la web
			@img=$img
			#$imgr=$img
			#@imgr=$imgr
			@nom=$namc
		else		  	
	  	$img0=$doc.css('[class="primary-image"]').attr('src').value
	  	@img=$img0
	  	#@img=$img0[0..-2]
	  	#$img=$img0[0..-4]+"2000"
	  	#@img=$img
	  	#nab=$img0.split("/").last
	  	#$namc=nab[0..-8]

		  	$imgaa=$browser.windows.last.url
		  	$imgab=$imgaa.split("/")[4]
		  	$imgabc=$imgab.split(".html").first
		  	#$namc=$imgabc.split("_").last+".jpg"
		  	$namc=$imgabc.split("_").last
		  	if $namc[0..1]=="OB" || $namc[0..1]=="OG"
		  		$namc=$namc[2..-1]
		  		
		  	end	
		  	@nom=$namc
		  	
	 	end

			@archivos=[""]
			@albumv=album
			#@alb = directorior[6..-1]+"/"
			@archivos=[]
			@archivost=[]
	  		@buscapro = lista
	  		@buscapro.each do |a|
	  			#$na=a[6..-1]
	  			#if $na==$namc
	  			if a.style==$namc	
	  				@archivos<<a
	  			
	  			end
	  		end
	  		#byebug
	  		 #temp = "public/images/temp"
	  		 #@temp = "/images/temp/"
	  		@buscapro=Temp.all
	  		@buscapro.each do |a|
	  			#$na=a[6..-1]
	  			#if $na==$namc
	  			if a.style==$namc	
	  				@archivost<<a
	  			end
	  		end 
	  	@ope="ch"
	  	@foto=foto
	else
		@ope="ts"
		@albumv=album
		@archivos=[]
		@foto=foto
		#temp = "public/images/temp"
		#@temp = "/images/temp/"
	end

	@architemp = Temp.all
	#@architemp1 = @architemp.delete_at(0);  
	#@architemp2 = @architemp1; 
	
	
	render :subir_producto;
	#byebug
	#.where(codebar:  @i_codebar_final).first
	# if @buscapro.blank?
  end

end
