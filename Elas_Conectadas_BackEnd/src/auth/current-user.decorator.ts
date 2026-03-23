import { createParamDecorator, ExecutionContext } from '@nestjs/common';

// Cria um decorator personalizado chamado de CurrentUser.
// Ele captura o request.user de retorno do método validate
export const CurrentUser = createParamDecorator(
  (data: unknown, ctx: ExecutionContext) => {
    const request = ctx.switchToHttp().getRequest();
    return request.user;
  },
);
