package connectx

import (
	"errors"
	"fmt"

	"connectrpc.com/connect"
)

func InvalidArgument(err any) error {
	return connect.NewError(connect.CodeInvalidArgument, asError(err))
}

func Unauthenticated(err any) error {
	return connect.NewError(connect.CodeUnauthenticated, asError(err))
}

func NotFound(err any) error {
	return connect.NewError(connect.CodeNotFound, asError(err))
}

func Internal(err any) error {
	return connect.NewError(connect.CodeInternal, asError(err))
}

func IsNotFound(err error) bool {
	var connectErr *connect.Error
	return errors.As(err, &connectErr) && connectErr.Code() == connect.CodeNotFound
}

func asError(value any) error {
	switch typed := value.(type) {
	case nil:
		return errors.New("unknown error")
	case error:
		return typed
	case string:
		return errors.New(typed)
	default:
		return fmt.Errorf("%v", typed)
	}
}
