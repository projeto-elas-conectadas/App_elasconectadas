import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNotEmpty, IsUUID, IsUrl, IsOptional, IsArray } from 'class-validator';

export class CreateProdutoDto {
  @ApiProperty({ example: 'Consultoria de TI' })
  @IsString()
  @IsNotEmpty()
  nome: string;

  @ApiProperty({ example: 'Manutenção de computadores' })
  @IsString()
  @IsNotEmpty()
  descricao: string;

  @ApiProperty({ 
    example: 'R$ 100 - R$ 150', 
    description: 'Preço ou margem de valor' 
  })
  @IsString() // MUDANÇA AQUI: Agora validamos como string!
  @IsNotEmpty()
  preco: string;

  @ApiProperty({ example: 'Serviços' })
  @IsString()
  @IsNotEmpty()
  categoria: string;

  @ApiProperty({ 
    example: 'Bandeirantes, Andirá ou a domicílio',
    description: 'Região onde a empreendedora atua'
  })
  @IsString() // NOVO CAMPO NO DTO
  @IsNotEmpty()
  regiaoAtendimento: string;

  @ApiProperty({ example: 'ID-DA-USUARIA' })
  @IsUUID()
  userId: string;

  @ApiProperty({ 
    example: 'https://minhaimagem.com/principal.jpg', 
    description: 'URL da imagem principal do produto' 
  })
  @IsString()
  @IsUrl()
  @IsNotEmpty()
  imagemPrincipal: string;

  @ApiProperty({ 
    example: ['https://foto1.jpg', 'https://foto2.jpg'], 
    description: 'URLs de imagens extras (Opcional)',
    required: false,
    type: [String] // Ajuda o Swagger a entender que é uma lista de textos
  })
  @IsOptional()
  @IsArray() // Garante que seja um Array/Lista
  @IsUrl({}, { each: true }) // A mágica aqui: Valida se CADA item do array é uma URL válida!
  imagensAdicionais?: string[];
}