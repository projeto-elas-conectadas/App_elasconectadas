import {
  ArgumentsHost,
  Catch,
  ExceptionFilter,
  HttpException,
  HttpStatus,
  Logger,
} from '@nestjs/common';
import { Response } from 'express';

type OpenApiErrorItem = {
  path?: string;
  message?: string;
};

type OpenApiLikeError = {
  status?: number;
  statusCode?: number;
  message?: string;
  path?: string;
  errors?: OpenApiErrorItem[];
};

@Catch()
export class HttpExceptionFilter implements ExceptionFilter {
  private readonly logger = new Logger(HttpExceptionFilter.name);

  catch(exception: unknown, host: ArgumentsHost) {
    const res = host.switchToHttp().getResponse<Response>();
    const body = this.buildBody(exception);

    this.logger.error(
      `${body.error} ${body.statusCode} ${body.path ?? ''}: ${this.stringifyMessage(body.message)}`,
    );

    if (res.headersSent) {
      return;
    }

    res.status(body.statusCode).json(body);
  }

  private buildBody(exception: unknown) {
    if (exception instanceof HttpException) {
      const statusCode = exception.getStatus();
      const response = exception.getResponse();
      const payload =
        typeof response === 'object' && response !== null
          ? (response as Record<string, unknown>)
          : { message: response };

      return {
        statusCode,
        message: payload.message ?? exception.message,
        error: payload.error ?? exception.name.replace(/Exception$/, ''),
        path: this.openApiPath(exception),
        errors: this.openApiErrors(exception),
      };
    }

    const openApi = exception as OpenApiLikeError;
    const statusCode =
      openApi.status ?? openApi.statusCode ?? HttpStatus.INTERNAL_SERVER_ERROR;
    const message =
      this.firstOpenApiMessage(openApi) ??
      (exception instanceof Error
        ? exception.message
        : 'Erro interno do servidor');

    return {
      statusCode,
      message,
      error: HttpStatus[statusCode] ?? 'Error',
      path: openApi.path,
      errors: openApi.errors,
    };
  }

  private openApiPath(exception: unknown): string | undefined {
    const candidate = exception as OpenApiLikeError;
    return typeof candidate.path === 'string' ? candidate.path : undefined;
  }

  private openApiErrors(exception: unknown): OpenApiErrorItem[] | undefined {
    const candidate = exception as OpenApiLikeError;
    return Array.isArray(candidate.errors) ? candidate.errors : undefined;
  }

  private firstOpenApiMessage(error: OpenApiLikeError): string | undefined {
    const fromList = error.errors?.find((item) => item.message)?.message;
    return fromList ?? error.message;
  }

  private stringifyMessage(message: unknown): string {
    if (Array.isArray(message)) {
      return message.join(', ');
    }
    return String(message ?? '');
  }
}
