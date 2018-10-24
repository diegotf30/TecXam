// The default response that all API calls will receive
export interface ServerResponse {
    data: any;
    success: boolean;
    error: string[];
    message: string;
}
