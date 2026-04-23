import {
  Body,
  Controller,
  Delete,
  Get,
  HttpException,
  Param,
  Patch,
  Post,
  UseGuards,
  UsePipes,
  ValidationPipe
} from '@nestjs/common';
import { CreateAdminDto } from './dtos/CreateAdmin.dto';
import { CreateUserDto } from './dtos/CreateUser.dto';
import { UpdateUserDto } from './dtos/UpdateUser.dto';
import { UsersService } from './users.service';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';

@Controller('users')
export class UsersController {
  constructor(private usersService: UsersService) {}

  @Post('register')
  @UsePipes(ValidationPipe)
  createUser(@Body() createUserDto: CreateUserDto) {
    return this.usersService.createUser(createUserDto, 'USER');
  }

  // Cria um novo usuário com o papel de administrador
  // É definido como 'ADMIN' por padrão e não pode ser acessado pela rota de registro
  @UseGuards(JwtAuthGuard)
  @Post('admin')
  @UsePipes(ValidationPipe)
  createAdmin(@Body() createAdminDto: CreateAdminDto) {
    return this.usersService.createUser(createAdminDto, 'ADMIN');
  }

  @UseGuards(JwtAuthGuard)
  @Get()
  getUsers() {
    return this.usersService.getUsers();
  }

  @UseGuards(JwtAuthGuard)
  @Get(':id')
  async getUserById(@Param('id') id: string) { // Removido o Pipe falso!
    const user = await this.usersService.getUserById(id);
    if (!user) throw new HttpException('User Not Found', 404);

    delete (user as { password?: string }).password;
    return user;
  }

  @UseGuards(JwtAuthGuard)
  @Patch(':id')
  updateUserById(
    @Param('id') id: string, // Removido o Pipe falso!
    @Body() updateUserDto: UpdateUserDto,
  ) {
    // Aqui nós "arrancamos" o pfp de dentro do DTO e guardamos o resto na variável "dadosParaSalvar"
    const { pfp, ...dadosParaSalvar } = updateUserDto;

    // Futuramente, é aqui que faremos o upload do 'pfp' para a nuvem!
    // Por enquanto, mandamos para o banco apenas os dados em texto (nome, email, etc)
    return this.usersService.updateUser(id, dadosParaSalvar);
  }

  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  deleteUserById(@Param('id') id: string) { // Removido o Pipe falso!
    return this.usersService.deleteUser(id);
  }
}