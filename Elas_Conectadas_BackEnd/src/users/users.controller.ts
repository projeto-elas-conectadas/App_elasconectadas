import {
  Body,
  Controller,
  Delete,
  Get,
  HttpException,
  Param,
  ParseIntPipe,
  Patch,
  Post,
  UseGuards,
  UsePipes,
  ValidationPipe,
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

  //cria um novo usuário com o papel de administrador
  //é definido como 'ADMIN' por padrão e não pode ser acessado pela rota de registro
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
  async getUserById(@Param('id', ParseIntPipe) id: number) {
    const user = await this.usersService.getUserById(id);
    if (!user) throw new HttpException('User Not Found', 404);

    delete (user as { password?: string }).password;
    return user;
  }

  @UseGuards(JwtAuthGuard)
  @Patch(':id')
  updateUserById(
    @Param('id', ParseIntPipe) id: number,
    @Body() updateUserDto: UpdateUserDto,
  ) {
    return this.usersService.updateUser(id, updateUserDto);
  }

  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  deleteUserById(@Param('id', ParseIntPipe) id: number) {
    return this.usersService.deleteUser(id);
  }
}
