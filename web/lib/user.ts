type Auth0UserInformation = {
    email: string;
    email_verified: boolean;
    given_name: string;
    family_name: string;
    nickname: string;
    locale: string;
    name: string;
    picture: string;
    sub: string;
    updated_at: string;
}

const baseUrl = "http://localhost:3000";
export const fetchUser = async (): Promise<Auth0UserInformation> => {
    const response = await fetch(`${baseUrl}/api/auth/me`);
    return await response.json();
}