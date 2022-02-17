import { Button } from "react-bootstrap";

export default function LoginButton({ children }): JSX.Element {
  return (
    <Button variant="primary" href="/api/auth/login">
      {children}
    </Button>
  );
}
